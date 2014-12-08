module.exports =
  default:
    dest: "public/"
    policy: [
      {
        ua: "*"
        disallow: "/"
      }
      {
        sitemap: [
          "http://staging.example.com/sitemap.xml"
        ]
      }
      {
        crawldelay: 100
      }
      {
        host: "staging.example.com"
      }
    ]
  production:
    dest: "public/"
    policy: [
      {
        ua: "*"
        allow: "/"
      }
      {
        sitemap: [
          "http://www.example.com/sitemap.xml"
        ]
      }
      {
        crawldelay: 100
      }
      {
        host: "www.example.com"
      }
    ]
