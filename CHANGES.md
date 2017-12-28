## 1.1.0

* https://github.com/openstax/openstax_salesforce/pull/10
* Added `Campaign` without many fields
* Fixes for relations between CampaignMember and Campaign (minor version bump because these were not used yet)
* Spec proxy helper additions for Campaign and CampaignMember

## 1.0.0

* Added `CampaignMember`, untested
* Added `application_source` to `Lead`
* Changed `Lead`'s `accounts_uuid` field to match what is in SF (`accounts_uuid_c__c`) - this is probably a typo in SF, but it is what is there now.
