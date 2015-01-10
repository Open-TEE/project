import qbs.Probes

// A Product Module (to allow Probes)
Product {
	id: OpenSSL

	Depends { name: "cpp" }

	Probes.PkgConfigProbe {
		id: opensslConfig
		name: "openssl"
	}

	cpp.linkerFlags: {
		if (!opensslConfig.found) {
			throw "OpenSSL not found by pkg-config"
		}

		return opensslConfig.libs;
	}
	cpp.cFlags: opensslConfig.cflags
}
