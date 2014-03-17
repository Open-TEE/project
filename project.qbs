import qbs

Project {
	qbsSearchPaths: ['project/qbs']

 	references: [
	    "emulator/emulator.qbs",
 	    "libtee/tee.qbs",
	    "test_clients/test_client.qbs"
	]
}
