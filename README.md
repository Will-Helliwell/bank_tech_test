# Bank Tech Test
---
## About

This is my submission to a sample tech test from the 10th week of the Makers Academy coding bootcamp. 

The challenge was to test-drive the creation of a simple REPL-based banking app from a pre-defined set of user stories ([jump to the Makers readme to see the original instructions in full](#Original-Specification).

This challenge allowed me to put into practice a lot of the principles and techniques learned on the course, including:
- TDD
- Test isolation using mocking
- Dependency injection
- DRY principles 

#### Screenshot of App in Use

![screenshot](https://github.com/Will-Helliwell/bank_tech_test/blob/master/bank_tech_test_screenshot.png
)

## Usage

### Setup

- `(git clone "https://github.com/Will-Helliwell/bank_tech_test" && cd bank_tech_test)` - Clone this repo and cd into it
- `bundle install` - Install dependencies

### Creating and Using an Account

The program can be run in any REPL.

E.g. if using IRB:
- `irb -r './lib/account.rb'` - Open IRB and load the files
- `your_account_name = Account.new` - Create your bank account

#### Public methods available
- `your_account_name.deposit(amount: 10)`
  - Adds the amount (in this case 10) to your bank balance and displays a confirmation message if successful
  - Adds the deposit to your transaction record
  - Raises an error if a non-integer is given as argument
  - Optional arguments available (only used for testing): date and transaction.

- `your_account_name.withdraw(10)`
  - Subtracts the amount (in this case 10) from your bank balance and displays a confirmation message if successful
  - Adds the withdrawal to your transaction record
  - Raises an error if a non-integer is given as argument
  - Raises an error if the withdrawal takes the balance below the MINIMUM_BALANCE (set at zero for now)
  - Optional arguments available (only used for testing): date and transaction.

- `your_account_name.print_balance`
  - Prints the current account balance

- `your_account_name.print_statement`
  - Prints a table in the console. Each represents a single transaction, and columns show the date it was made, debit amount, credit amount and resulting account balance.

#### Running Tests

- `rspec` (must be in root folder)
- All tests passing
- Coverage:
  - 100%
  - 17 unit tests
  - 2 feature tests, including 'acceptance criteria' from original specification.
- Isolation - Account and Transaction class tests 100% isolated

## Specification, Approach and Extensions

### User Stories
```
As an new user
So that I can store my money
I want to be given a fresh account with zero balance

As an account owner
So that I can store my money
I want to be able to deposit money to my account

As an account owner
So that I can use my stored money
I want to be able to withdraw money from my account

As an account owner
Because I do not have an overdraft arrangement
I want to be barred from reducing my balance below zero

As an account owner
So that I can keep track of my account balance
I want to be able to print an account statement showing date, debit, credit and balance
```
### Aproach Taken

- Simple class plan (below) to get an idea of the overall structure
- Then followed the TDD process, using the user stories as a scaffold

### Application Type

- Minimal user interface required - no front-end or even input via STDin. User can interact with their account using set commands directly in a REPL.
- No persistence - all data regarding existing accounts is wiped once the REPL session is terminated.
- No stated requirement for security
- No stated requirement for an overdraft - assume for now that balance cannot go below zero

**Interpretation** - my natural instinct here would have been to create a program with an account class, where new users can create their own instance of a bank account with a security layer (at least account number and encrypted password). The account history and balance could then be persisted in a database, allowing the user to log back into their account.

However, the user-stories seem deliberately minimal. Only the basic functionality for the account class is required at this stage. I have drawn up the below user stories to reflect this.

**Class Structure** - initial plan
- Class = Account
- Attributes:
  - balance (default is zero)
  - transactions = array of transactions
- Methods:
  - withdraw
  - deposit
  - print_balance (no stated requirement for this but it makes sense as a public method and will be very useful for testing behaviour rather than state)
  - print_statement

- Class 2 = Transaction
  - This might be worth extracting into a separate class, but I shall make that extraction if and when required.
  - Choice - I chose to make transaction a separate class (rather than, for example, recording the transactions for an account as an array of hashes) because to me transactions and accounts were two distinct objects with distinct responsibilities (holding data for a single transaction vs holding data and amending details for the entire account respectively).

### Other Notable Choices Made During Development

- **Dependency injection of Transaction into Account** - currently injectected in two places: as optional arguments to withdraw and deposit methods. Another option would be to inject into the Account via initilizer, using @current_withdrawal and @current_deposit respectively. These would then be updated on withdrawal/deposit and a copy added to the @transactions array. This would avoid having to pass a fake transaction into the withdraw/deposit methods each time they are called in tests, instead passing via the initializer. However, it would also be more complicated to set up the double since it would need to respond to setter methods. I also think the code would be less easy to follow if written like this.

- **Terminal-table gem dependancy** - I chose to use this gem instead of coding my own table generator from scratch, as it had all of the functionality I required.

- **Return value for print_statement** - currently I am allowing the Account.print_statement to return the @transactions data as an array of arrays (the data structure required as input for the terminal-table gem). I have kept it like this because the method has to return something (even in print_table were the last line, it would return nil when run in the REPL) and the specification does not communicate a preference.
- Keeping it like this is beneficial for testing because it allows the tests to analyze the array of arrays (which is simpler than analyzing the console table structure). If I make the reasonable assumption that the terminal-table gem works as marketed, then testing the array of arrays is also functionally equivalent.
- If the client displayed a preference down the line, this could easily be modified.



### Suggested Extensions
- Maximum account balance
- Data persistence - connect to a database
- Security - can only access account with the correct encrypted password
- Users can have multiple accounts
- Web-based UI

---

# Original Specification

Today, you'll practice doing a tech test.

For most tech tests, you'll essentially have unlimited time. This practice session is about producing the best code you can when there is a minimal time pressure.

You'll get to practice your OO design and TDD skills.

You'll work alone, and you'll also review your own code so you can practice reflecting on and improving your own work.

## Specification

### Requirements
- You should be able to interact with your code via a REPL like IRB or the JavaScript console. (You don't need to implement a command line interface that takes input from STDIN.)
- Deposits, withdrawal.
- Account statement (date, amount, balance) printing.
- Data can be kept in memory (it doesn't need to be stored to a database or anything).

### Acceptance criteria

Given a client makes a deposit of 1000 on 10-01-2012
And a deposit of 2000 on 13-01-2012
And a withdrawal of 500 on 14-01-2012
When she prints her bank statement
Then she would see

date || credit || debit || balance
14/01/2012 || || 500.00 || 2500.00
13/01/2012 || 2000.00 || || 3000.00
10/01/2012 || 1000.00 || || 1000.00
