#!/bin/bash

mongod &

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MongoDB service startup"
    sleep 5
    mongo admin --eval "help" >/dev/null 2>&1
    RET=$?
done

MONGODB_DB=${MONGODB_DB:-"supply"} # ver pq nao ta pegando mais a variavel de ambiente
MONGODB_USERNAME=${MONGODB_USERNAME:-"root"}
MONGODB_PASSWORD=${MONGODB_PASSWORD:-"root"}

echo "=> Creating an admin user in MongoDB"
mongo admin --eval "db.createUser({user: '$MONGODB_USERNAME', pwd: '$MONGODB_PASSWORD', roles:[{role:'root',db:'admin'}]});"

echo "=> ${MONGODB_DB} != admin"

if [ "$MONGODB_DB" != "admin" ]; then
    echo "=> Creating an ${MONGODB_USERNAME} user with a ${MONGODB_PASSWORD} password in MongoDB"
    mongo admin -u $MONGODB_USERNAME -p $MONGODB_PASSWORD << EOF
use $MONGODB_DB
db.createUser({user: '$MONGODB_USERNAME', pwd: '$MONGODB_PASSWORD', roles:[{role:'dbOwner',db:'$MONGODB_DB'}]})
EOF
fi

echo "=> Done!"

mongod --shutdown