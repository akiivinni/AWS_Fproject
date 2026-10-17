
ADMIN@DESKTOP-N4EIOID MINGW64 ~/downloads (master)
$ employee-project-key.pem
bash: employee-project-key.pem: command not found

ADMIN@DESKTOP-N4EIOID MINGW64 ~/downloads (master)
$ chmod 400 employee-project-key.pem

ADMIN@DESKTOP-N4EIOID MINGW64 ~/downloads (master)
$ ssh -i employee-project-key.pem ec2-user@18.215.248.57
The authenticity of host '18.215.248.57 (18.215.248.57)' can't be established.
ED25519 key fingerprint is: SHA256:vBaSW1lC0hmovn6JGycvSrebFlUeolOmb65a7IPMj+0
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '18.215.248.57' (ED25519) to the list of known hosts.
** WARNING: connection is not using a post-quantum key exchange algorithm.
** This session may be vulnerable to "store now, decrypt later" attacks.
** The server may need to be upgraded. See https://openssh.com/pq.html
   ,     #_
   ~\_  ####_        Amazon Linux 2023
  ~~  \_#####\
  ~~     \###|
  ~~       \#/ ___   https://aws.amazon.com/linux/amazon-linux-2023
   ~~       V~' '->
    ~~~         /
      ~~._.   _/
         _/ _/
       _/m/'
[ec2-user@ip-172-31-36-244 ~]$ ^C
[ec2-user@ip-172-31-36-244 ~]$
