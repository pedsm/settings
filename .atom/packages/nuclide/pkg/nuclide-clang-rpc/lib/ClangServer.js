'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _asyncToGenerator = _interopRequireDefault(require('async-to-generator'));

var _nuclideUri;

function _load_nuclideUri() {
  return _nuclideUri = _interopRequireDefault(require('../../commons-node/nuclideUri'));
}

var _nuclideMarshalersCommon;

function _load_nuclideMarshalersCommon() {
  return _nuclideMarshalersCommon = require('../../nuclide-marshalers-common');
}

var _idx;

function _load_idx() {
  return _idx = _interopRequireDefault(require('idx'));
}

var _rxjsBundlesRxMinJs = require('rxjs/bundles/Rx.min.js');

var _process2;

function _load_process() {
  return _process2 = require('../../commons-node/process');
}

var _nuclideRpc;

function _load_nuclideRpc() {
  return _nuclideRpc = require('../../nuclide-rpc');
}

var _nuclideFilewatcherRpc;

function _load_nuclideFilewatcherRpc() {
  return _nuclideFilewatcherRpc = require('../../nuclide-filewatcher-rpc');
}

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the license found in the LICENSE file in
 * the root directory of this source tree.
 *
 * 
 */

let serviceRegistry = null;

function getServiceRegistry() {
  if (serviceRegistry == null) {
    serviceRegistry = new (_nuclideRpc || _load_nuclideRpc()).ServiceRegistry((_nuclideMarshalersCommon || _load_nuclideMarshalersCommon()).getServerSideMarshalers, (0, (_nuclideRpc || _load_nuclideRpc()).loadServicesConfig)((_nuclideUri || _load_nuclideUri()).default.join(__dirname, '..')), 'clang_language_service');
  }
  return serviceRegistry;
}

function spawnClangProcess(src, serverArgsPromise, flagsPromise) {
  return _rxjsBundlesRxMinJs.Observable.fromPromise(Promise.all([serverArgsPromise, flagsPromise])).switchMap(([serverArgs, flagsData]) => {
    var _ref;

    const flags = (_ref = flagsData) != null ? _ref.flags : _ref;
    if (flags == null) {
      // We're going to reject here.
      // ClangServer will also dispose itself upon encountering this.
      throw new Error(`No flags found for ${src}`);
    }
    const { libClangLibraryFile, pythonPathEnv, pythonExecutable } = serverArgs;
    const pathToLibClangServer = (_nuclideUri || _load_nuclideUri()).default.join(__dirname, '../python/clang_server.py');
    const args = [pathToLibClangServer];
    if (libClangLibraryFile != null) {
      args.push('--libclang-file', libClangLibraryFile);
    }
    args.push('--', src);
    args.push(...flags);
    const options = {
      cwd: (_nuclideUri || _load_nuclideUri()).default.dirname(pathToLibClangServer),
      stdio: 'pipe',
      detached: false, // When Atom is killed, clang_server.py should be killed, too.
      env: {
        PYTHONPATH: pythonPathEnv
      },
      /* TODO(T17353599) */isExitError: () => false
    };

    // Note that safeSpawn() often overrides options.env.PATH, but that only happens when
    // options.env is undefined (which is not the case here). This will only be an issue if the
    // system cannot find `pythonExecutable`.
    return (0, (_process2 || _load_process()).spawn)(pythonExecutable, args, options);
  });
}

class ClangServer {

  constructor(src, contents, serverArgsPromise, flagsPromise) {
    this._usesDefaultFlags = false;
    this._pendingCompileRequests = 0;
    this._serverStatus = new _rxjsBundlesRxMinJs.BehaviorSubject(ClangServer.Status.FINDING_FLAGS);
    this._flagsChanged = false;
    this._flagsSubscription = _rxjsBundlesRxMinJs.Observable.fromPromise(flagsPromise).do(flagsData => {
      if (flagsData == null) {
        // Servers without flags will be left in the 'disposed' state forever.
        // This ensures that all language requests bounce without erroring.
        this.dispose();
        return;
      }
      this._usesDefaultFlags = flagsData.usesDefaultFlags;
    }).switchMap(flagsData => {
      if (flagsData != null && flagsData.flagsFile != null) {
        return (0, (_nuclideFilewatcherRpc || _load_nuclideFilewatcherRpc()).watchFile)(flagsData.flagsFile).refCount().take(1);
      }
      return _rxjsBundlesRxMinJs.Observable.empty();
    }).subscribe(x => {
      this._flagsChanged = true;
    }, () => {});
    this._rpcProcess = new (_nuclideRpc || _load_nuclideRpc()).RpcProcess(`ClangServer-${src}`, getServiceRegistry(), spawnClangProcess(src, serverArgsPromise, flagsPromise));
    // Kick off an initial compilation to provide an accurate server state.
    // This will automatically reject if any kind of disposals/errors happen.
    this.compile(contents).catch(() => {});
  }

  dispose() {
    this._serverStatus.next(ClangServer.Status.DISPOSED);
    this._serverStatus.complete();
    this._rpcProcess.dispose();
    this._flagsSubscription.unsubscribe();
  }

  getService() {
    if (this.isDisposed()) {
      throw new Error('Called getService() on a disposed ClangServer');
    }
    return this._rpcProcess.getService('ClangProcessService');
  }

  /**
   * Returns RSS of the child process in bytes.
   * Works on Unix and Mac OS X.
   */
  getMemoryUsage() {
    var _this = this;

    return (0, _asyncToGenerator.default)(function* () {
      const { _process } = _this._rpcProcess;
      if (_process == null) {
        return 0;
      }
      const { exitCode, stdout } = yield (0, (_process2 || _load_process()).asyncExecute)('ps', ['-p', _process.pid.toString(), '-o', 'rss=']);
      if (exitCode !== 0) {
        return 0;
      }
      return parseInt(stdout, 10) * 1024; // ps returns KB
    })();
  }

  getFlagsChanged() {
    return this._flagsChanged;
  }

  // Call this instead of using the RPC layer directly.
  // This way, we can track when the server is busy compiling.
  compile(contents) {
    var _this2 = this;

    return (0, _asyncToGenerator.default)(function* () {
      const service = yield _this2.getService();
      if (_this2._pendingCompileRequests++ === 0) {
        _this2._serverStatus.next(ClangServer.Status.COMPILING);
      }
      try {
        return yield service.compile(contents).then(function (result) {
          return Object.assign({}, result, {
            accurateFlags: !_this2._usesDefaultFlags
          });
        });
      } finally {
        if (--_this2._pendingCompileRequests === 0 && !_this2.isDisposed()) {
          _this2._serverStatus.next(ClangServer.Status.READY);
        }
      }
    })();
  }

  getStatus() {
    return this._serverStatus.getValue();
  }

  isDisposed() {
    return this.getStatus() === ClangServer.Status.DISPOSED;
  }

  isReady() {
    return this.getStatus() === ClangServer.Status.READY;
  }

  waitForReady() {
    if (this.getStatus() === ClangServer.Status.READY) {
      return Promise.resolve();
    }
    return this._serverStatus.takeWhile(x => x !== ClangServer.Status.READY).toPromise();
  }
}
exports.default = ClangServer;
ClangServer.Status = Object.freeze({
  FINDING_FLAGS: 'finding_flags',
  COMPILING: 'compiling',
  READY: 'ready',
  DISPOSED: 'disposed'
});