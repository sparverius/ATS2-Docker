VERSION := 0.3.13

default:: ; \
sudo docker build \
--build-arg _VERSION=${VERSION} \
-t telos/ats2:${VERSION} .

intknd:: ; \
sudo docker build \
--build-arg _VERSION=${VERSION} \
--build-arg _KND=int \
-t telos/ats2:${VERSION}-int .

gmpknd:: ; \
sudo docker build \
--build-arg _VERSION=${VERSION} \
--build-arg _KND=gmp \
-t telos/ats2:${VERSION}-gmp .

all:: default 
all:: intknd
all:: gmpknd
