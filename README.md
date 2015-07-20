myiis-cookbook Cookbook
=======================
Microsoft IIS(Internet Information Services) cookbook that can be used to install and deploy code into IIS.

Requirements
------------

#### COOKBOOKS
- `git` - required by the `app_checkout` recipe in order to install `git` and use it through the custom `git` resource
- `msdeploy` - required by the `app_msdeploy_import` recipe in order to install `msdeploy` and use it through the custom `msdeploy_sync` resource

Attributes
----------

#### myiis-cookbook::app_checkout
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['myiis-cookbook']['git-repo']</tt></td>
    <td>String</td>
    <td>Git repository where the code will be deployed from. Only used by the app_checkout recipe</td>
    <td><tt>https://github.com/alexpop/myhtml-app</tt></td>
  </tr>
  <tr>
    <td><tt>['myiis-cookbook']['doc-root']</tt></td>
    <td>String</td>
    <td>Directory where the code will be deployed to by the app_checkout recipe</td>
    <td><tt>c:/inetpub/wwwroot</tt></td>
  </tr>
  <tr>
    <td><tt>['myiis-cookbook']['git-revision']</tt></td>
    <td>String</td>
    <td>Directory where the code will be deployed to by the app_checkout recipe</td>
    <td><tt>master</tt></td>
  </tr>
</table>

#### myiis-cookbook::app_msdeploy_import
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['myiis-cookbook']['msdeploy']['zip']</tt></td>
    <td>String</td>
    <td>HTTP(S) location where the msdeploy package can be downloaded from</td>
    <td><tt>https://s3-eu-west-1.amazonaws.com/apop-bucket/all_sites-latest.zip</tt></td>
  </tr>
</table>

Usage
-----

 * Add the `default` recipe to the `run_list` to idempotantly install `IIS` (Internet Information Services)
 * Use the `app_checkout` recipe to deploy IIS code from a git repository. Or, use the `app_msdeploy_import` to import code from an HTTP location using msdeploy sync
 * Add `install_google_chrome` to the `run_list` for more browsing options
