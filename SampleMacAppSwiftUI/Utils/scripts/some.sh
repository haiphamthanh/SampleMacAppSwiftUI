#!/bin/bash
# https://transang.me/encrypt-decrypt-files-directory-with-openssl/

# tar -Jcf "${file_name}.tar.xz" -C . "${dir_name}"

# if [[ $(openssl version) == "OpenSSL 1.1.1"* ]]; then
# 	cipher="-pbkdf2"
# else
# 	cipher="-aes-256-cbc"
# fi

# openssl enc ${cipher} \
# 	-in "${file_name}" \
# 	-out "${file_name}.enc" \
# 	-md sha512 -salt \
# 	-pass "pass:${ENCRYPTION_PASSWORD}"


# openssl enc -d ${cipher} \
# 	-in "${file_name}.enc" \
# 	-out "${file_name}" \
# 	-md sha512 -salt \
# 	-pass "pass:${ENCRYPTION_PASSWORD}"




if [[ $(openssl version) == "OpenSSL 1.1.1"* ]]; then
	cipher="-pbkdf2"
else
	cipher="-aes-256-cbc"
fi

# dir_name=./dir
# file_name=sample
# tar -Jcf "${file_name}.tar.xz" -C . "${dir_name}"

# file_name="${file_name}.tar.xz"
# openssl enc ${cipher} \
# 	-in "${file_name}" \
# 	-out "${file_name}.enc" \
# 	-md sha512 -salt \
# 	-pass "pass:${ENCRYPTION_PASSWORD}"

openssl enc -d ${cipher} \
	-in "sample.tar.xz.enc" \
	-out "sample.new.tar.xz" \
	-md sha512 -salt \
	-pass "pass:${ENCRYPTION_PASSWORD}"
