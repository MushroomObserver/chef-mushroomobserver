mushroomobserver Cookbook
=========================

Chef cookbook for creating Mushroom Observer (http://mushroomobserver.org) systems

Requirements
------------
No requirements so far, but I hope to have some someday.

e.g.
#### packages
- `toaster` - mushroomobserver needs toaster to brown your bagel.

Attributes
----------
No attributes yet, but I hope to have some someday.

e.g.
#### mushroomobserver::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['mushroomobserver']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### mushroomobserver::default

I want to be able to both create a developer machine and the production machine using
this cookbook.

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[mushroomobserver]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Nathan Wilson
License: MIT (like all things Mushroom Observer)
