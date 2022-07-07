package router

import (
	v1 "santa/api/v1"

	"github.com/gin-gonic/gin"
)

func Init{{.StructName}}Router(Router *gin.RouterGroup) {
	{{.Abbreviation}}Router := Router.Group("{{ ReplaceCurlyToColon .UrlPathRmLast }}")
	{
		{{.Abbreviation}}Router.GET("{{ ReplaceCurlyToColon (SubstringAfterLast .UrlPath "/")}} ", v1.Get{{.StructName}})
		{{.Abbreviation}}Router.PUT("{{ ReplaceCurlyToColon (SubstringAfterLast .UrlPath "/")}} ", v1.Delete{{.StructName}})
		{{.Abbreviation}}Router.DELETE("{{ ReplaceCurlyToColon (SubstringAfterLast .UrlPath "/")}} ", v1.Create{{.StructName}})

		{{.Abbreviation}}Router.POST("", v1.Create{{.StructName}})
		{{.Abbreviation}}Router.GET("", v1.List{{.StructName}})
	}
}
