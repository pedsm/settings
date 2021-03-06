'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _react = _interopRequireDefault(require('react'));

var _SettingsControl;

function _load_SettingsControl() {
  return _SettingsControl = _interopRequireDefault(require('./SettingsControl'));
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

class SettingsCategory extends _react.default.Component {

  render() {
    const children = Object.keys(this.props.packages).sort().map(pkgName => {
      const pkgData = this.props.packages[pkgName];
      const settingsArray = getSortedSettingsArray(pkgData.settings, pkgName);
      const elements = settingsArray.map(settingName => {
        const settingData = pkgData.settings[settingName];
        return _react.default.createElement(
          ControlGroup,
          { key: settingName },
          _react.default.createElement((_SettingsControl || _load_SettingsControl()).default, {
            keyPath: settingData.keyPath,
            value: settingData.value,
            onChange: settingData.onChange,
            schema: settingData.schema
          })
        );
      });
      // We create a control group for the whole group of controls and then another for each
      // individual one. Why? Because that's what Atom does in its settings view.
      return _react.default.createElement(
        ControlGroup,
        { key: pkgName },
        _react.default.createElement(
          'section',
          { className: 'sub-section' },
          _react.default.createElement(
            'h2',
            { className: 'sub-section-heading' },
            pkgData.title
          ),
          _react.default.createElement(
            'div',
            { className: 'sub-section-body' },
            elements
          )
        )
      );
    });
    return _react.default.createElement(
      'section',
      { className: 'section settings-panel' },
      _react.default.createElement(
        'h1',
        { className: 'block section-heading icon icon-gear' },
        this.props.name,
        ' Settings'
      ),
      children
    );
  }
}

exports.default = SettingsCategory;
function ControlGroup(props) {
  return _react.default.createElement(
    'div',
    { className: 'control-group' },
    _react.default.createElement(
      'div',
      { className: 'controls' },
      props.children
    )
  );
}

function getSortedSettingsArray(settings, pkgName) {
  // Sort the package's settings by name, then by order.
  const settingsArray = Object.keys(settings);
  settingsArray.sort().sort((a, b) => settings[a].order - settings[b].order);
  return settingsArray;
}