'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.MultiRootChangedFilesView = undefined;

var _nuclideVcsBase;

function _load_nuclideVcsBase() {
  return _nuclideVcsBase = require('../nuclide-vcs-base');
}

var _goToLocation;

function _load_goToLocation() {
  return _goToLocation = require('../commons-atom/go-to-location');
}

var _openInDiffView;

function _load_openInDiffView() {
  return _openInDiffView = require('../commons-atom/open-in-diff-view');
}

var _nuclideAnalytics;

function _load_nuclideAnalytics() {
  return _nuclideAnalytics = require('../nuclide-analytics');
}

var _nuclideUri;

function _load_nuclideUri() {
  return _nuclideUri = _interopRequireDefault(require('../commons-node/nuclideUri'));
}

var _react = _interopRequireDefault(require('react'));

var _UniversalDisposable;

function _load_UniversalDisposable() {
  return _UniversalDisposable = _interopRequireDefault(require('../commons-node/UniversalDisposable'));
}

var _ChangedFilesList;

function _load_ChangedFilesList() {
  return _ChangedFilesList = _interopRequireDefault(require('./ChangedFilesList'));
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

const ANALYTICS_PREFIX = 'changed-files-view';
const DEFAULT_ANALYTICS_SOURCE_KEY = 'command';

class MultiRootChangedFilesView extends _react.default.PureComponent {

  constructor(props) {
    super(props);
    this._handleAddFile = this._handleAddFile.bind(this);
    this._handleDeleteFile = this._handleDeleteFile.bind(this);
    this._handleForgetFile = this._handleForgetFile.bind(this);
    this._handleOpenFileInDiffView = this._handleOpenFileInDiffView.bind(this);
    this._handleRevertFile = this._handleRevertFile.bind(this);
  }

  componentDidMount() {
    this._subscriptions = new (_UniversalDisposable || _load_UniversalDisposable()).default();
    const {
      commandPrefix,
      openInDiffViewOption
    } = this.props;
    this._subscriptions.add(atom.contextMenu.add({
      [`.${commandPrefix}-file-entry`]: [{ type: 'separator' }, {
        label: 'Add file to Mercurial',
        command: `${commandPrefix}:add`,
        shouldDisplay: event => {
          return this._getStatusCodeForFile(event) === (_nuclideVcsBase || _load_nuclideVcsBase()).FileChangeStatus.UNTRACKED;
        }
      }, {
        label: 'Open file in Diff View',
        command: `${commandPrefix}:open-in-diff-view`,
        shouldDisplay: event => {
          return atom.packages.isPackageLoaded('fb-diff-view') && openInDiffViewOption;
        }
      }, {
        label: 'Revert File',
        command: `${commandPrefix}:revert`,
        shouldDisplay: event => {
          const statusCode = this._getStatusCodeForFile(event);
          if (statusCode == null) {
            return false;
          }
          return (_nuclideVcsBase || _load_nuclideVcsBase()).RevertibleStatusCodes.includes(statusCode);
        }
      }, {
        label: 'Delete File',
        command: `${commandPrefix}:delete-file`,
        shouldDisplay: event => {
          const statusCode = this._getStatusCodeForFile(event);
          return statusCode !== (_nuclideVcsBase || _load_nuclideVcsBase()).FileChangeStatus.REMOVED;
        }
      }, {
        label: 'Goto File',
        command: `${commandPrefix}:goto-file`
      }, {
        label: 'Copy File Name',
        command: `${commandPrefix}:copy-file-name`
      }, {
        label: 'Copy Full Path',
        command: `${commandPrefix}:copy-full-path`
      }, {
        label: 'Forget file',
        command: `${commandPrefix}:forget-file`,
        shouldDisplay: event => {
          const statusCode = this._getStatusCodeForFile(event);
          return statusCode !== (_nuclideVcsBase || _load_nuclideVcsBase()).FileChangeStatus.REMOVED && statusCode !== (_nuclideVcsBase || _load_nuclideVcsBase()).FileChangeStatus.UNTRACKED;
        }
      }, { type: 'separator' }]
    }));

    this._subscriptions.add(atom.commands.add(`.${commandPrefix}-file-entry`, `${commandPrefix}:goto-file`, event => {
      const filePath = this._getFilePathFromEvent(event);
      if (filePath != null && filePath.length) {
        (0, (_goToLocation || _load_goToLocation()).goToLocation)(filePath);
      }
    }));

    this._subscriptions.add(atom.commands.add(`.${commandPrefix}-file-entry`, `${commandPrefix}:copy-full-path`, event => {
      atom.clipboard.write((_nuclideUri || _load_nuclideUri()).default.getPath(this._getFilePathFromEvent(event) || ''));
    }));
    this._subscriptions.add(atom.commands.add(`.${commandPrefix}-file-entry`, `${commandPrefix}:delete-file`, event => {
      const nuclideFilePath = this._getFilePathFromEvent(event);
      this._handleDeleteFile(nuclideFilePath);
    }));
    this._subscriptions.add(atom.commands.add(`.${commandPrefix}-file-entry`, `${commandPrefix}:copy-file-name`, event => {
      atom.clipboard.write((_nuclideUri || _load_nuclideUri()).default.basename(this._getFilePathFromEvent(event) || ''));
    }));
    this._subscriptions.add(atom.commands.add(`.${commandPrefix}-file-entry`, `${commandPrefix}:add`, event => {
      const filePath = this._getFilePathFromEvent(event);
      if (filePath != null && filePath.length) {
        this._handleAddFile(filePath);
      }
    }));
    this._subscriptions.add(atom.commands.add(`.${commandPrefix}-file-entry`, `${commandPrefix}:revert`, event => {
      const filePath = this._getFilePathFromEvent(event);
      if (filePath != null && filePath.length) {
        this._handleRevertFile(filePath);
      }
    }));
    this._subscriptions.add(atom.commands.add(`.${commandPrefix}-file-entry`, `${commandPrefix}:open-in-diff-view`, event => {
      const filePath = this._getFilePathFromEvent(event);
      if (filePath != null && filePath.length) {
        this._handleOpenFileInDiffView(filePath);
      }
    }));
    this._subscriptions.add(atom.commands.add(`.${commandPrefix}-file-entry`, `${commandPrefix}:forget-file`, event => {
      const filePath = this._getFilePathFromEvent(event);
      if (filePath != null && filePath.length) {
        this._handleForgetFile(filePath);
      }
    }));
  }

  _getStatusCodeForFile(event) {
    // Walk up the DOM tree to the element containing the relevant data- attributes.
    const target = event.target.closest('.nuclide-file-changes-list-item');

    if (!target) {
      throw new Error('Invariant violation: "target"');
    }

    const filePath = target.getAttribute('data-path');
    const rootPath = target.getAttribute('data-root');
    // $FlowFixMe
    const fileChangesForRoot = this.props.fileChanges.get(rootPath);

    if (!fileChangesForRoot) {
      throw new Error('Invalid rootpath');
    }
    // $FlowFixMe


    const statusCode = fileChangesForRoot.get(filePath);
    return statusCode;
  }

  _getFilePathFromEvent(event) {
    const eventTarget = event.currentTarget;
    // $FlowFixMe
    return eventTarget.getAttribute('data-path');
  }

  _getAnalyticsSurface() {
    const { analyticsSurface } = this.props;
    return analyticsSurface == null ? 'n/a' : analyticsSurface;
  }

  _handleAddFile(filePath, analyticsSource = DEFAULT_ANALYTICS_SOURCE_KEY) {
    (0, (_nuclideVcsBase || _load_nuclideVcsBase()).addPath)(filePath);
    (0, (_nuclideAnalytics || _load_nuclideAnalytics()).track)(`${ANALYTICS_PREFIX}-add-file`, {
      source: analyticsSource,
      surface: this._getAnalyticsSurface()

    });
  }

  _handleDeleteFile(filePath, analyticsSource = DEFAULT_ANALYTICS_SOURCE_KEY) {
    (0, (_nuclideVcsBase || _load_nuclideVcsBase()).confirmAndDeletePath)(filePath);
    (0, (_nuclideAnalytics || _load_nuclideAnalytics()).track)(`${ANALYTICS_PREFIX}-delete-file`, {
      source: analyticsSource,
      surface: this._getAnalyticsSurface()
    });
  }

  _handleForgetFile(filePath, analyticsSource = DEFAULT_ANALYTICS_SOURCE_KEY) {
    (0, (_nuclideVcsBase || _load_nuclideVcsBase()).forgetPath)(filePath);
    (0, (_nuclideAnalytics || _load_nuclideAnalytics()).track)(`${ANALYTICS_PREFIX}-forget-file`, {
      source: analyticsSource,
      surface: this._getAnalyticsSurface()
    });
  }

  _handleOpenFileInDiffView(filePath, analyticsSource = DEFAULT_ANALYTICS_SOURCE_KEY) {
    (0, (_openInDiffView || _load_openInDiffView()).openFileInDiffView)(filePath);
    (0, (_nuclideAnalytics || _load_nuclideAnalytics()).track)(`${ANALYTICS_PREFIX}-file-in-diff-view`, {
      source: analyticsSource,
      surface: this._getAnalyticsSurface()
    });
  }

  _handleRevertFile(filePath, analyticsSource = DEFAULT_ANALYTICS_SOURCE_KEY) {
    const { getRevertTargetRevision } = this.props;
    let targetRevision = null;
    if (getRevertTargetRevision != null) {
      targetRevision = getRevertTargetRevision();
    }
    (0, (_nuclideVcsBase || _load_nuclideVcsBase()).confirmAndRevertPath)(filePath, targetRevision);
    (0, (_nuclideAnalytics || _load_nuclideAnalytics()).track)(`${ANALYTICS_PREFIX}-revert-file`, {
      source: analyticsSource,
      surface: this._getAnalyticsSurface()
    });
  }

  render() {
    const {
      commandPrefix,
      enableInlineActions,
      fileChanges: fileChangesByRoot,
      hideEmptyFolders,
      onFileChosen,
      selectedFile
    } = this.props;
    if (fileChangesByRoot.size === 0) {
      return _react.default.createElement(
        'div',
        null,
        'No changes'
      );
    }
    const shouldShowFolderName = fileChangesByRoot.size > 1;
    return _react.default.createElement(
      'div',
      { className: 'nuclide-ui-multi-root-file-tree-container' },
      Array.from(fileChangesByRoot.entries()).map(([root, fileChanges]) => _react.default.createElement((_ChangedFilesList || _load_ChangedFilesList()).default, {
        commandPrefix: commandPrefix,
        enableInlineActions: enableInlineActions === true,
        fileChanges: fileChanges,
        hideEmptyFolders: hideEmptyFolders,
        key: root,
        onAddFile: this._handleAddFile,
        onDeleteFile: this._handleDeleteFile,
        onFileChosen: onFileChosen,
        onForgetFile: this._handleForgetFile,
        onOpenFileInDiffView: this._handleOpenFileInDiffView,
        onRevertFile: this._handleRevertFile,
        rootPath: root,
        selectedFile: selectedFile,
        shouldShowFolderName: shouldShowFolderName
      }))
    );
  }

  componentWillUnmount() {
    this._subscriptions.dispose();
  }
}
exports.MultiRootChangedFilesView = MultiRootChangedFilesView;