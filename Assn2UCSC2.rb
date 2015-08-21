#
#  Author - John McKellar (johnm)
#  Course - U.C. Santa Cruz 21342.(036)
#  Assignment #2 - Ruby
#  August 10, 2015
#
#  The following program outputs a sequence of prime numbers. The user can specify different
#  algorithms to run by entering an integer from the console prompt. If no integer is given,
#  a default algorithm will be used.
#
#  SAMPLE INPUT (run from a UNIX console):
#    ruby Assn2UCSC2.rb 1
#
#  In the sample input above, the first algorithm was chosen. If the integer is too high, a
#  default algorithm will be used. If more than one integer is given, only the first will be
#  used.
#
require 'prime'



class PrimeNumberPrinter
#
#  This class uses multiple algorithms to compute a sequence of prime numbers.
#

  def initialize()
  #
  #  Method initialize is used to select which of the algorithms defined in the class will
  #  be run.
  #
  #  PARAMETERS:
  #    None.
  #
  #  OUTPUT:
  #    None.
  #
  #  REVISION HISTORY:
  #    08/06/15 johnm - initial coding.
  #

    algorithm_number = ARGV.length > 0 ? ARGV.first : DEFAULT_ALGORITHM
    case algorithm_number.to_i
      when 1
        firstPrimeList
      when 2
        secondPrimeList
      else # use default algorithm
        thirdPrimeList
    end # case
  end #initialize



  def firstPrimeList
  #
  #  Method firstPrimeList computes the first list of prime numbers. Each integer in a
  #  sequence will be examined. 
  #
  #  PARAMETERS:
  #    None.
  #
  #  OUTPUT:
  #    None.
  #
  #  REVISION HISTORY:
  #    08/04/15 johnm - initial coding.
  #

    puts "First Prime List:";  col_index = 1;  start_time = Time.now
    for prime_candidate in 1..NUMBER_OF_CANDIDATES
      if thisIsPrime?(prime_candidate)
        printPrimeResult(prime_candidate, col_index)
        col_index = updateColIndex(col_index)
      end # if
    end # for    
    total_time = (Time.now - start_time) * MICRO_SECOND_FACTOR
    puts "\nTotal time elapsed: #{total_time} microseconds.\n\n"  
  end # firstPrimeList


  
  def secondPrimeList
  #
  #  Method secondPrimeList computes the second list of prime numbers. Each even integer
  #  in a sequence will be examined. This is expected to be faster than evaluating odd and
  #  even integers.
  #
  #  PARAMETERS:
  #    None.
  #
  #  OUTPUT:
  #    None.
  #
  #  REVISION HISTORY:
  #    08/05/15 johnm - initial coding.
  #

    puts "Second Prime List:";  prime_candidate = 1;  col_index = 1
    start_time = Time.now
    while prime_candidate <= NUMBER_OF_CANDIDATES
      if thisIsPrime?(prime_candidate)
        printPrimeResult(prime_candidate, col_index)
        col_index = updateColIndex(col_index)
      end # if
      prime_candidate += prime_candidate <= 2 ? 1 : 2
    end # while 
    total_time = (Time.now - start_time) * MICRO_SECOND_FACTOR
    puts "\nTotal time elapsed: #{total_time} microseconds.\n\n"
  end # secondPrimeList



  def thirdPrimeList
  #
  #  Method thirdPrimeList computes the third list of prime numbers. Each even integer in
  #  a sequence will be evaluated, using Ruby's built-in algorithms.
  #
  #  PARAMETERS:
  #    None.
  #
  #  OUTPUT:
  #    None.
  #
  #  REVISION HISTORY:
  #    08/03/15 johnm - initial coding.
  #

    puts "Third Prime List:";  prime_candidate = 1;  col_index = 1
    start_time = Time.now
    while prime_candidate <= NUMBER_OF_CANDIDATES
      if Prime.instance.prime?(prime_candidate)
        printPrimeResult(prime_candidate, col_index)
        col_index = updateColIndex(col_index)
      end # if
      prime_candidate += prime_candidate <= 2 ? 1 : 2
    end # while
    total_time = (Time.now - start_time) * MICRO_SECOND_FACTOR
    puts "\nTotal time elapsed: #{total_time} microseconds.\n"
  end # thirdPrimeList



  protected
    def thisIsPrime?(prime_candidate)
    #
    #  Method thisIsPrime determines whether an integer is a prime number.
    #
    #  PARAMETERS:
    #    prime_candidate - a positive integer to be examined for primality.
    #
    #  OUTPUT:
    #    True if the candidate is determined to be prime, false otherwise.
    #
    #  REVISION HISTORY:
    #    08/03/15 johnm - initial coding.
    #

      not_prime = prime_candidate == 1 or prime_candidate == 2
      this_denominator = 2
      while !not_prime && this_denominator < prime_candidate
        if prime_candidate % this_denominator == 0
          not_prime = true          
        else
          this_denominator += 1
        end # if else
      end # while
      return !not_prime
    end # thisIsPrime



    def printPrimeResult(prime_candidate, col_index)
    #
    #  Method printPrimeResult prints the resulting prime number and is intended to be used
    #  for an output matrix.
    #
    #  PARAMETERS:
    #    prime_candidate - a positivie number to be examined for primality.
    #    col_index - column index to position the candidate within the matrix.
    #
    #  OUTPUT:
    #    None.
    #
    #  REVISION HISTORY:
    #    08/03/15 johnm - initial coding.
    #

      printf("%4d ", prime_candidate)
      if col_index >= COLUMNS_PER_LINE
        print "\n"
      end # if
    end # printPrimeResult



    def updateColIndex(col_index)
    #
    #  Method updateColIndex updates the column index so that it never exceeds the columns-per-
    #  line constant value.
    #
    #  PARAMETERS:
    #    col_index - column index to position the candidate within the matrix.
    #
    #  OUTPUT:
    #    None.
    #
    #  REVISION HISTORY:
    #    08/03/15 johnm - initial coding.
    #

      return col_index >= COLUMNS_PER_LINE ? 1 : col_index + 1
    end # updateColIndex  


 
  private
    DEFAULT_ALGORITHM = 3
    COLUMNS_PER_LINE = 10
    NUMBER_OF_CANDIDATES = 1000
    MICRO_SECOND_FACTOR = 1000
end # PrimeNumberPrinter



johnmsPrimeNumberPrinter = PrimeNumberPrinter.new()



