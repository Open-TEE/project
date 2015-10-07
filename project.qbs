import qbs

Project {
	qbsSearchPaths: ['project/qbs']

 	references: {
 	    var binaries = [
	    "emulator/emulator.qbs",
 	    "libtee/libtee.qbs",
            "tests/tests.qbs",
            "CAs/ClientApplications.qbs",
            "TAs/TrustedApplications.qbs",
	    "libtee_pkcs11/libtee_pkcs11.qbs"
	     ]

	if (File.exists(sourceDirectory + "/libomnishare/libomnishare.qbs")) {
               binaries.push("libomnishare/libomnishare.qbs")
        }
        return binaries
	}
}
