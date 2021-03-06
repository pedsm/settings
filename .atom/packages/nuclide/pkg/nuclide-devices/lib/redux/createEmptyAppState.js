'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.createEmptyAppState = createEmptyAppState;
function createEmptyAppState(deviceFetchers, deviceInfoProviders) {
  return {
    hosts: ['local'],
    host: 'local',
    devices: [],
    deviceType: null,
    device: null,
    infoTables: new Map(),
    deviceFetchers,
    deviceInfoProviders
  };
} /**
   * Copyright (c) 2015-present, Facebook, Inc.
   * All rights reserved.
   *
   * This source code is licensed under the license found in the LICENSE file in
   * the root directory of this source tree.
   *
   * 
   */