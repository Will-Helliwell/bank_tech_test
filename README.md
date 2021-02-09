# Bank Tech Test - Will's Readme

## Usage

- Clone this repo and cd into it `(git clone "https://github.com/Will-Helliwell/bank_tech_test" && cd bank_tech_test)`
- Install dependencies `bundle install`

The program can then be run in any REPL.

E.g. if using IRB:
- Open IRB and load the files - `irb -r './lib/account.rb'`
- Create your bank account `your_account_name = Account.new`

Public methods that can be called on your account:
- `your_account_name.deposit(amount: 10)`
  - Adds the amount (in this case 10) to your bank balance and displays a confirmation message if successful
  - Adds the deposit to your transaction record
  - Raises an error if a non-integer is given as argument
  - Optional arguments (only used for testing) = date and transaction

- `your_account_name.withdraw(integer)`
- `your_account_name.print_balance`
- `your_account_name.print_statement`




## Spec Interpretation

### Application Type

- Minimal user interface required - no front-end or even input via STDin. User can interact with their account using set commands directly in a REPL.
- No persistence - on running the program, a 'fresh' account with zero balance is generated
- No stated requirement for multiple users or security
- No stated requirement for an overdraft - assume balance cannot go below zero

**Interpretation** - my natural instinct here would have been to create a program with an account class, where new users can create their own instance of a bank account with a security layer (at least account number and encrypted password). The account history and balance could then be persisted in a database.

However, the requirements seem deliberately minimal. Only the basic functionality for a single account is required at this stage. I have drawn up the below user stories to reflect this.

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

  ### Other Choices Made During Development

  - Dependency injection of Transaction into Account - currently inject in two places: as optional arguments to withdraw and deposit methods. Another option would be to inject into the Account via initilizer, using @current_withdrawl and @current_deposit respectively. These would then be updated on withdrawl/deposit and a copy added to the @transactions array. This would avoid having to pass a fake transaction into the withdraw/deposit methods each time they are called in tests. However, it would also be more complicated to set up the double, and I think the code would be less easy to follow this way.
  - With the current injection method, I cannot write an automated feature test to pass the acceptance criteria (although it would pass if I could) because

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

# Bank Tech Test - Original Spec
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
