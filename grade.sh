CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'
TESTFILE='TestListExamples'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if [[ -f student-submission/ListExamples.java ]]
then
    echo 'ListExamples.java submitted'
else
    echo 'ListExamples.java not submitted'
    exit
fi

cp student-submission/ListExamples.java ./grading-area
cp TestListExamples.java ./grading-area

javac -cp $CPATH grading-area/*.java

if [[ $? != 0 ]]
then
    echo 'files failed to compile'
else
    echo 'files compiled'
fi

java -cp $CPATH org.junit.runner.JUnitCore grading-area/$TESTFILE > results.txt

FAILURES=`grep -c "FAILURES!!!" results.txt`
RESULTS=`grep "Tests run" results.txt`

echo ''
echo 'RESULTS:'
echo $RESULTS

if [[ $FAILURES -eq 0 ]]
then
    echo 'All tests passed'
fi

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
