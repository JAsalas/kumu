divider(){
    printf "%-s \n" "------------------------------------------------------------------"
}

entrypoint_label(){
    printf "%-s\n" "[ENTRYPOINT] running $1..."
}

entrypoint_label "parallel-lint"
parallel-lint  app #.results.errors (count)

entrypoint_label "phpstan" 
phpstan analyse app #.errors (count)

entrypoint_label "phpcs"
phpcs --colors --report=diff,full app # .totals.errors (Count)

entrypoint_label "local-php-security-checker"
local-php-security-checker  app # . (count)

entrypoint_label "phpcd"
phpcpd app # Print 2nd/3rd line

echo "============================= SUMMARY ============================"

printf "| %-30s | %-30s%1s\n" "parallel-lint" "$(parallel-lint --json app | jq '.results.errors | length') error/s found" "|"
#parallel-lint --json app | jq '.results.errors | length'
divider

printf "| %-30s | %-30s%1s\n"  "phpstan" "$(phpstan analyse --no-progress --error-format=json app | jq '.errors | length') error/s found" "|"
#phpstan analyse --no-progress --error-format=json app | jq '.errors | length'
divider

printf "| %-30s | %-30s%1s\n"  "phpcs" "$(phpcs --report=json app | jq '.totals.errors | length') error/s found" "|"
#phpcs --report=json app | jq '.totals.errors | length'
divider

printf "| %-30s | %-30s%1s\n" "local-php-security-checker" "$(local-php-security-checker -format=json app | jq '. | length') vulnerability/ies found" "|"
#local-php-security-checker -format=json app | jq '. | length'
divider

printf "| %-30s | %-30s%1s\n"  "phpcpd results" "$(phpcpd app | grep found)" "|"
# phpcd app | grep found
divider

echo "Thanks!"
#phpcpd app | grep found