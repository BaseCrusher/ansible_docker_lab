#!/bin/bash
ssh -o StrictHostKeyChecking=no  -o "UserKnownHostsFile=/dev/null" ansible@localhost -p 2022  