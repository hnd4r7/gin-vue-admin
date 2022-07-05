package router

import (
	v1 "santa/api/v1"

	"github.com/gin-gonic/gin"
)

func Init{{.StructName}}Router(Router *gin.RouterGroup) {
	{{.Abbreviation}}Router := Router.Group("{{.Abbreviation}}")
	{
		{{.Abbreviation}}Router.GET(":id", v1.Get{{.StructName}})
		{{.Abbreviation}}Router.GET("", v1.List{{.StructName}})
		{{.Abbreviation}}Router.POST("", v1.Create{{.StructName}})
		{{.Abbreviation}}Router.DELETE(":id", v1.Delete{{.StructName}})
		{{.Abbreviation}}Router.PUT(":id", v1.Update{{.StructName}})
	}
}
