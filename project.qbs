import qbs

Project {
 	references: [
	    "emulator/emu.qbs",
 	    "libtee/tee.qbs",
	    "test_clients/test_client.qbs"
	]
}