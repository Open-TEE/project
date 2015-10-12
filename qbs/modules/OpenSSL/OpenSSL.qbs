import qbs.Probes
import opentee.probehelper

Module {
	id: OpenSSL

	Depends { name: "cpp" }

	Probes.PkgConfigProbe {
		id: opensslConfig
		name: "openssl"
	}

	// Parse flags returned by pkg-config not having -l in front of them
	cpp.linkerFlags: {
                if (!opensslConfig.found) {
                        throw "OpenSSL not found by pkg-config"
                }

		return probehelper.getLinkerFlags(opensslConfig.libs);
	}

	// Parse flags returned by pkg-config that have -l in front of them
	cpp.dynamicLibraries: {
                if (!opensslConfig.found) {
                        throw "OpenSSL not found by pkg-config"
                }

		return probehelper.getLibraries(opensslConfig.libs);
	}

	cpp.cxxFlags: opensslConfig.cflags
}
