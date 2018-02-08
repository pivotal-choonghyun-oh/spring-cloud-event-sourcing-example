#!/bin/sh

rm -f ./c1.txt ./step?.out

curl -X GET 'http://online-store-web.apps.sec.mzdemo.net/login' -H 'Referer: http://online-store-web.apps.sec.mzdemo.net/' -k -L -c ./c1.txt -b ./c1.txt  -o ./step1.out


curl -L -X POST 'http://user-service.apps.sec.mzdemo.net/uaa/login' -H 'Referer: http://user-service.apps.sec.mzdemo.net/uaa/login' -H 'Content-Type: application/x-www-form-urlencoded' --data 'username=user&password=password' -k -v -c ./c1.txt -b ./c1.txt -o ./step2.out

curl -L 'http://user-service.apps.sec.mzdemo.net/uaa/oauth/authorize' -H 'Host: user-service.apps.sec.mzdemo.net' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:58.0) Gecko/20100101 Firefox/58.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Referer: http://user-service.apps.sec.mzdemo.net/uaa/login' -H 'Content-Type: application/x-www-form-urlencoded' --data 'user_oauth_approval=true&scope.openid=true' -k -v -c ./c1.txt -b ./c1.txt -o ./step3.out


curl -L 'http://online-store-web.apps.sec.mzdemo.net/api/user/uaa/v1/me' -H 'Host: online-store-web.apps.sec.mzdemo.net' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:58.0) Gecko/20100101 Firefox/58.0' -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Referer: http://online-store-web.apps.sec.mzdemo.net/' -H 'Cache-Control: max-age=0' -k -v -c ./c1.txt -b ./c1.txt -o ./step4.out


curl 'http://online-store-web.apps.sec.mzdemo.net/api/account/v1/accounts' -H 'Host: online-store-web.apps.sec.mzdemo.net' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:58.0) Gecko/20100101 Firefox/58.0' -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Referer: http://online-store-web.apps.sec.mzdemo.net/' -L -k -v -c ./c1.txt -b ./c1.txt -o ./step5.out


# orders

curl 'http://online-store-web.apps.sec.mzdemo.net/api/order/v1/accounts/12345/orders' -H 'Host: online-store-web.apps.sec.mzdemo.net' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:58.0) Gecko/20100101 Firefox/58.0' -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Referer: http://online-store-web.apps.sec.mzdemo.net/' -L -k -v -c ./c1.txt -b ./c1.txt -o ./step6.out

#catalog

curl 'http://online-store-web.apps.sec.mzdemo.net/api/catalog/v1/catalog' -H 'Host: online-store-web.apps.sec.mzdemo.net' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:58.0) Gecko/20100101 Firefox/58.0' -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Referer: http://online-store-web.apps.sec.mzdemo.net/'  -L -k -v -c ./c1.txt -b ./c1.txt -o ./step7.out


# click a t-shirt
curl 'http://online-store-web.apps.sec.mzdemo.net/api/catalog/v1/products/SKU-24642' -H 'Host: online-store-web.apps.sec.mzdemo.net' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:58.0) Gecko/20100101 Firefox/58.0' -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Referer: http://online-store-web.apps.sec.mzdemo.net/index.html'   -L -k -v -c ./c1.txt -b ./c1.txt -o ./step8.out

# add to cart
curl 'http://online-store-web.apps.sec.mzdemo.net/api/shoppingcart/v1/events' -H 'Host: online-store-web.apps.sec.mzdemo.net' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:58.0) Gecko/20100101 Firefox/58.0' -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Referer: http://online-store-web.apps.sec.mzdemo.net/index.html' -H 'Content-Type: application/json' --data '{"cartEventType":"ADD_ITEM","productId":"SKU-24642","quantity":"1"}' -L -k -v -c ./c1.txt -b ./c1.txt -o ./step9.out


# shopping card

curl 'http://online-store-web.apps.sec.mzdemo.net/api/shoppingcart/v1/cart' -H 'Host: online-store-web.apps.sec.mzdemo.net' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:58.0) Gecko/20100101 Firefox/58.0' -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Referer: http://online-store-web.apps.sec.mzdemo.net/'  -L -k -v -c ./c1.txt -b ./c1.txt -o ./step10.out


# check-out

curl 'http://online-store-web.apps.sec.mzdemo.net/api/shoppingcart/v1/checkout' -H 'Host: online-store-web.apps.sec.mzdemo.net' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:58.0) Gecko/20100101 Firefox/58.0' -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Referer: http://online-store-web.apps.sec.mzdemo.net/' -H 'Content-Type: application/json' --data '{}'  -L -k -v -c ./c1.txt -b ./c1.txt -o ./step11.out

