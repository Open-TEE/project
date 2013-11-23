import qbs

Project {
 	references: [
	    "emulator/emulator.qbs",
 	    "libtee/tee.qbs",
	    "test_clients/test_client.qbs"
	]
}