import qbs.Probes
import opentee.probehelper

Module {
	id: fuse

	Depends { name: "cpp" }

	Probes.PkgConfigProbe {
		id: fuseConfig
		name: "fuse"
	}

	// Parse flags returned by pkg-config not having -l in front of them
	cpp.linkerFlags: {
                if (!fuseConfig.found) {
                        throw "fuse not found by pkg-config"
                }

		return probehelper.getLinkerFlags(fuseConfig.libs);
	}

	// Parse flags returned by pkg-config that have -l in front of them
	cpp.dynamicLibraries: {
                if (!fuseConfig.found) {
                        throw "fuse not found by pkg-config"
                }

		return probehelper.getLibraries(fuseConfig.libs);
	}

	cpp.cFlags: fuseConfig.cflags
}
