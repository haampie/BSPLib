rm -rf gcov
rm -rf target/site/clover
mkdir gcov
cd gcov/
gcov --object-directory ../bin/obj/x32/Coverage/bsp-test/* ../test
lcov --capture --base-directory ../test --directory .. --directory ../test/ --directory ../bsp/include/ --output-file coverage.info --no-external
genhtml coverage.info --output-directory ../target/site/clover
python  ../extern/gcov/gcov_to_clover.py *.gcov