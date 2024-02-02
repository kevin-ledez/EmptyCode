
# colors
yellow="\033[33m"
blue="\033[34m"
nc="\033[0m"

if [ $1 = "start-env-dev" ]; then
    echo -e "\n==>$yellow Installation of PHP dependencies$nc"
    symfony composer install --no-interaction

    #echo -e "==>$yellow Generate the SSL keys$nc"
    #symfony console lexik:jwt:generate-keypair --overwrite

    #echo -e "==>$yellow Update migrations$nc"
    #symfony console doctrine:migrations:migrate --no-interaction

    #echo -e "==>$yellow Load fixtures$nc"
    #symfony console doctrine:fixtures:load --no-interaction

    echo -e "\n==>$yellow Start api server$nc\n"
    symfony server:start --no-tls

elif [ $1 = "security-checker" ]; then
    echo "==>$yellow Security Checker$nc\n"
    symfony check:security

elif [ $1 = "phpcs" ]; then
    echo "==>$yellow PHP_CodeSniffer$nc\n"
    ./vendor/bin/phpcs -v --standard=PSR12 --ignore=./src/Kernel.php ./src

elif [ $1 = "phpstan" ]; then
    echo "==>$yellow PHPStan$nc\n"
    ./vendor/bin/phpstan analyse ./src

elif [ $1 = "phpunit" ]; then
    echo "==>$yellow PHPUnit$nc\n"
    echo "\n"
    ./vendor/bin/phpunit --testsuite ordered

else
    clear
    while :; do
        echo "\n==> You wish run :" \
            "\n$yellow [1]$nc Security Checker" \
            "\n$yellow [2]$nc PHP_CodeSniffer" \
            "\n$yellow [3]$nc PHPStan" \
            "\n$yellow [4]$nc PHPUnit" \
            "\n$yellow [5]$nc PHPUnit coverage" \
            "\n---------------------" \
            "\n$yellow [6]$nc Load fixtures" \
            "\n$yellow [7]$nc Clear cache" \
            "\n---------------------" \
            "\n$yellow [t]$nc Docker terminal\n"

        read -p "Choose a number [ ] : " response

        if [ "$response" = 1 ]; then
            clear
            echo "==>$yellow Security Checker$nc\n"
            symfony check:security

        elif [ "$response" = 2 ]; then
            clear
            echo "==>$yellow PHP_CodeSniffer$nc\n"
            ./vendor/bin/phpcs -v --standard=PSR12 --ignore=./src/Kernel.php ./src

        elif [ "$response" = 3 ]; then
            clear
            echo "==>$yellow PHPStan$nc\n"
            ./vendor/bin/phpstan analyse ./src

        elif [ "$response" = 4 ]; then
            clear
            echo "==>$yellow PHPUnit$nc\n"
            echo "\n"
            ./vendor/bin/phpunit --testsuite ordered

        elif [ "$response" = 5 ]; then
            clear
            echo "==>$yellow PHPUnit coverage$nc\n"
            echo "\n"
            ./vendor/bin/phpunit --testsuite ordered --coverage-html var/log/test/test-coverage
            echo "\n==> You can see the result with$yellow /api/var/log/test/test-coverage/index.html$nc"

        elif [ "$response" = 6 ]; then
            clear
            echo "==>$yellow Load fixtures$nc\n"
            symfony console doctrine:fixtures:load --no-interaction

        elif [ "$response" = 7 ]; then
            clear
            echo "==>$yellow Clear cache$nc\n"
            symfony console cache:clear

        elif [ "$response" = "t" ]; then
            clear
            bash
            break

        else
            echo "\n==>$blue Thanks and see you soon ;)$nc\n"
            break

        fi

    done
fi
