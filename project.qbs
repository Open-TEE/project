import qbs

Project {
	qbsSearchPaths: ['project/qbs']

 	references: [
	    "emulator/emulator.qbs",
 	    "libtee/tee.qbs",
        "tests/tests.qbs",
        "TAs/TrustedApplications.qbs"
	]
}
