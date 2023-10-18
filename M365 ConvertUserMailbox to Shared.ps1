#Convert list of emails from User Mailboxes to Shared
# Connect-ExchangeOnline

$names = @("name1@domain.com","name2@domain.com")

foreach ($name in $names) {
Set-Mailbox -Identity $name -Type Shared
Echo $name
}