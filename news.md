---
layout: default
title: News
---

##News Archive

{% for post in site.posts %}
  **{{ post.date | date_to_long_string }}**<br />
  [{{ post.title }}]({{post.url}})<br />
  {{ post.summary }}

  <br />
{% endfor %}