#!/bin/bash
# Author: Michael Hiiva
# Description:
# - Wrapper script to include the environmental variables from apache2.

## Membership Manager Environment
export MM_ADMIN_DEBUG_MODE={{ mm_admin_debug_mode }}
export MM_FRONTEND_DEBUG_MODE={{ mm_frontend_debug_mode }}
export MM_SITE_URL={{ mm_site_url }}
export MM_CONTACT_EMAIL={{ mm_contact_email }}
export MM_ERROR_EMAIL={{ mm_error_email }}
export MM_ADMIN_SITEPATH={{ mm_admin_sitepath }}
export MM_FRONTEND_SITEPATH={{ mm_frontend_sitepath }}
export MM_DB_HOST={{ mm_db_host }}
export MM_DB_NAME={{ mm_db_name }}
export MM_DB_USER={{ mm_db_user }}
export MM_DB_PASS={{ mm_db_pass }}

## Membership Manager PayPal Environment
export MM_PAYPAL_PAY_URL={{ mm_paypal_pay_url }}
export PAYPAL_PDT_ID={{ mm_paypal_pdt_id }}
export PAYPAL_BUSINESS_ID={{ mm_paypal_business_id }}

# Run the Membership Manager scheduler.php
if [[ -x '/usr/bin/php' ]] && \
   [[ -f "{{ usgo_org_www_root }}/membership_manager/app/scheduler.php" ]]; then
    /usr/bin/php -f '{{ usgo_org_www_root }}/membership_manager/app/scheduler.php'
fi
