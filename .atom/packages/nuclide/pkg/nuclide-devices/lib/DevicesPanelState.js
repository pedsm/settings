'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.DevicesPanelState = exports.WORKSPACE_VIEW_URI = undefined;

var _react = _interopRequireDefault(require('react'));

var _renderReactRoot;

function _load_renderReactRoot() {
  return _renderReactRoot = require('../../commons-atom/renderReactRoot');
}

var _DevicePanel;

function _load_DevicePanel() {
  return _DevicePanel = require('./ui/DevicePanel');
}

var _rxjsBundlesRxMinJs = require('rxjs/bundles/Rx.min.js');

var _bindObservableAsProps;

function _load_bindObservableAsProps() {
  return _bindObservableAsProps = require('../../nuclide-ui/bindObservableAsProps');
}

var _Actions;

function _load_Actions() {
  return _Actions = _interopRequireWildcard(require('./redux/Actions'));
}

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } else { var newObj = {}; if (obj != null) { for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) newObj[key] = obj[key]; } } newObj.default = obj; return newObj; } }

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

const WORKSPACE_VIEW_URI = exports.WORKSPACE_VIEW_URI = 'atom://nuclide/devices';

class DevicesPanelState {

  constructor(store) {
    this._store = store;
  }

  getTitle() {
    return 'Devices';
  }

  getIconName() {
    return 'device-mobile';
  }

  getPreferredWidth() {
    return 300;
  }

  getURI() {
    return WORKSPACE_VIEW_URI;
  }

  getDefaultLocation() {
    return 'right';
  }

  _appStateToProps(state) {
    const refreshDevices = host => {
      this._store.dispatch((_Actions || _load_Actions()).refreshDevices());
    };
    const setHost = host => {
      this._store.dispatch((_Actions || _load_Actions()).setHost(host));
    };
    const setDeviceType = deviceType => {
      this._store.dispatch((_Actions || _load_Actions()).setDeviceType(deviceType));
    };
    const setDevice = device => {
      this._store.dispatch((_Actions || _load_Actions()).setDevice(device));
    };
    return {
      devices: state.devices,
      hosts: state.hosts,
      host: state.host,
      deviceTypes: Array.from(state.deviceFetchers).map(fetcher => fetcher.getType()),
      deviceType: state.deviceType,
      device: state.device,
      infoTables: state.infoTables,
      refreshDevices,
      setHost,
      setDeviceType,
      setDevice
    };
  }

  getElement() {
    const PreparedDevicePanel = (0, (_bindObservableAsProps || _load_bindObservableAsProps()).bindObservableAsProps)(
    // $FlowFixMe: Teach flow about Symbol.observable
    _rxjsBundlesRxMinJs.Observable.from(this._store).distinctUntilChanged().map(state => this._appStateToProps(state)), (_DevicePanel || _load_DevicePanel()).DevicePanel);

    return (0, (_renderReactRoot || _load_renderReactRoot()).renderReactRoot)(_react.default.createElement(PreparedDevicePanel, null));
  }

  serialize() {
    return {
      deserializer: 'nuclide.DevicePanelState'
    };
  }
}
exports.DevicesPanelState = DevicesPanelState;