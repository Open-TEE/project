import qbs

Project {
	qbsSearchPaths: ['project/qbs']

 	references: [
	    "emulator/emulator.qbs",
 	    "libtee/libtee.qbs",
            "tests/tests.qbs",
            "CAs/ClientApplications.qbs",
            "TAs/TrustedApplications.qbs"
	]
}
