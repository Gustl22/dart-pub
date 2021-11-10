// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub/src/exit_codes.dart' as exit_codes;

import 'package:test/test.dart';

import '../descriptor.dart' as d;
import '../test_pub.dart';

void main() {
  setUp(d.validPackage.create);

  test('preview package validation has no warnings', () async {
    var pkg =
        packageMap('test_pkg', '1.0.0', null, null, {'sdk': '>=1.8.0 <2.0.0'});
    await d.dir(appPath, [d.pubspec(pkg)]).create();

    await servePackages((_) {});
    var pub = await startPublish(globalPackageServer, args: ['--dry-run']);

    await pub.shouldExit(exit_codes.SUCCESS);
    expect(pub.stderr, emitsThrough('Package has 0 warnings.'));
  });
}
