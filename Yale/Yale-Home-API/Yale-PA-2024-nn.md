# Yale-PA-2024-nn

## CVE Number

TBA

## Summary

An unauthorized modification of a Yale Home user account can be carried out by exploiting vulnerabilities in the "forgot password" process.

## Tested Versions

Yale Home android app version 2024.10.0 and Yale Linus Smart Lock L1 version dlg-3.2.2

## Product URLs

[Vendor Website](https://yalehome.it/)

## CVSSv4 Score

Score 6.9/10 (Medium)

CVSS:4.0/AV:N/AC:L/AT:N/PR:N/UI:N/VC:L/VI:L/VA:N/SC:N/SI:N/SA:N

## CWE

- CWE-862: Missing Authorization

## Details

There was a flaw in the authorisation mechanism that, under certain circumstances,
could have led to unauthorised modification of the user account. An attacker would have
been able to abuse the forgot password flow to change the Yale Home user's email
address and phone number, for which they knew one of those values. This would have
allowed them to change the password, which would have then led to an account
takeover.