// SPDX-License-Identifier: Apache-2.0
// Copyright Authors of go-faster

package helm

import "embed"

//go:embed *.tgz
var HelmFS embed.FS
