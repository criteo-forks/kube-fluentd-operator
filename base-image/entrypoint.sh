#!/usr/bin/dumb-init /bin/sh

# Copyright © 2018 VMware, Inc. All Rights Reserved.
# SPDX-License-Identifier: BSD-2-Clause


# roughly based on https://github.com/fluent/fluentd-kubernetes-daemonset/blob/master/docker-image/v0.12/debian-elasticsearch/entrypoint.sh
# the main difference is that a failsafe configuration is generated at boot time
# to prevent pod failing

set -e

if [ ! -e /fluentd/etc/${FLUENTD_CONF} ]; then
   echo "Using failsafe configuration for now"
   cp /fluentd/failsafe.conf /fluentd/etc/${FLUENTD_CONF}
fi

# Fix position old files remain
# https://github.com/fluent/fluentd-kubernetes-daemonset/issues/245
# This is generally a bad idea but as it is containers, it shouldn't resend all the logs anytime
# due to pod deletion on upgrade
rm -f /var/log/*.pos

exec fluentd -c /fluentd/etc/${FLUENTD_CONF} -p /fluentd/plugins ${FLUENTD_OPT}
