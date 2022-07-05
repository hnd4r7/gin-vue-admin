package request

import (
	"santa/model"
)

type {{.StructName}}Search struct{
    model.{{.StructName}}
    PageInfo
}