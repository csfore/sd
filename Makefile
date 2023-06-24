env:
	@echo "making test environment"
	@mkdir test
	@touch test/file1
	@touch test/file2
	@mkdir test/sub
	@touch test/sub/subfile 

rm:
	@echo "deleting test environment"
	@rm -rf test/
	@rm -rf /home/csfore/.cache/sd_bin

clean: rm env