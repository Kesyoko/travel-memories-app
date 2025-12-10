module ApplicationHelper
  def default_meta_tags
    {
       site: "記すたび",
       title: "旅行記録が届きました",
       reverse: true,
       charset: "utf-8",
       description: "このリンクから届いた旅行記録をご覧いただけます。",
       keywords: "旅行記録,旅記録,非SNS型,旅,記録",
       canonical: request.original_url,
       separator: "|",
       icon: [
         { href: image_url("1travel_logo"), sizes: "60x60" },
         { href: image_url("1travel_logo"), rel: "app/assets/images/1travel_logo.png", sizes: "180x180", type: "image/png" }
       ],
       og: {
         site_name: :site,
         title: :title,
         description: :description,
         type: "website",
         url: request.original_url,
         image: image_url("1travel_logo.png"),
         local: "ja-JP"
       }
     }
   end
end
