package request

import (
	"santa/model"
)

type {{.StructName}}Search struct{
    *PageInfo
    model.{{.StructName}}
}