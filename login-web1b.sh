#!/bin/bash
USERNAME=$(sed -n -e 's/^login_name=//p' /etc/hsl.def)
ssh -A ${USERNAME}@10.0.1.52
