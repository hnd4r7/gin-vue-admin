package v1
import (
	"santa/global"
	"santa/model"
	"santa/service"
	"santa/model/response"
	"santa/model/request"
	
	"strconv"

	"go.uber.org/zap"
	"github.com/gin-gonic/gin"
)

// Create{{.StructName}} 创建{{.StructName}}
// @Tags {{.StructName}}
// @Summary 创建{{.StructName}}
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Param data body model.{{.StructName}} true "创建{{.StructName}}"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"获取成功"}"
// @Router /api/v1/{{.Abbreviation}} [post]
func Create{{.StructName}}(c *gin.Context) {
	var {{.Abbreviation}} model.{{.StructName}}
	err := c.ShouldBindJSON(&{{.Abbreviation}})
	if err != nil {
		response.FailWithMessage("参数错误", err, c)
		return
	}
	if err := service.Create{{.StructName}}({{.Abbreviation}}); err != nil {
        global.LOG.Error("创建失败!", zap.Any("err", err))
		response.FailWithMessage("创建失败", err, c)
	} else {
		response.OkWithMessage("创建成功", c)
	}
}

// Delete{{.StructName}} 删除{{.StructName}}
// @Tags {{.StructName}}
// @Summary 删除{{.StructName}}
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json 
// @Param id path int true "ID"
// @Param data body model.{{.StructName}} true "删除{{.StructName}}"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"删除成功"}"
// @Router /api/v1/{{.Abbreviation}}/{id} [delete]
func Delete{{.StructName}}(c *gin.Context) {
	var {{.Abbreviation}} model.{{.StructName}}
	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		response.FailWithMessage("id不正确", err, c)
		return
	}
	err = c.ShouldBindJSON(&{{.Abbreviation}})
	if err != nil {
		response.FailWithMessage("参数错误", err, c)
		return
	}
	{{.Abbreviation}}.ID = uint(id)
	if err := service.Delete{{.StructName}}({{.Abbreviation}}); err != nil {
        global.LOG.Error("删除失败!", zap.Any("err", err))
		response.FailWithMessage("删除失败", err, c)
	} else {
		response.OkWithMessage("删除成功", c)
	}
}

// Update{{.StructName}} 更新{{.StructName}}
// @Tags {{.StructName}}
// @Summary 更新{{.StructName}}
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Param id path int true "ID"
// @Param data body model.{{.StructName}} true "更新{{.StructName}}"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"更新成功"}"
// @Router /api/v1/{{.Abbreviation}}/{id} [put]
func Update{{.StructName}}(c *gin.Context) {
	var {{.Abbreviation}} model.{{.StructName}}
	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		response.FailWithMessage("id不正确", err, c)
		return
	}
	err = c.ShouldBindJSON(&{{.Abbreviation}})
	if err != nil {
		response.FailWithMessage("参数错误", err, c)
		return
	}
	{{.Abbreviation}}.ID = uint(id)
	if err := service.Update{{.StructName}}({{.Abbreviation}}); err != nil {
        global.LOG.Error("更新失败!", zap.Any("err", err))
		response.FailWithMessage("更新失败", err, c)
	} else {
		response.OkWithMessage("更新成功", c)
	}
}

// Get{{.StructName}} 用id查询{{.StructName}}
// @Tags {{.StructName}}
// @Summary 用id查询{{.StructName}}
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Param data query model.{{.StructName}} true "用id查询{{.StructName}}"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"查询成功"}"
// @Router /api/v1/{{.Abbreviation}}/{id} [get]
func Get{{.StructName}}(c *gin.Context) {
	var {{.Abbreviation}} model.{{.StructName}}
	_ = c.ShouldBindQuery(&{{.Abbreviation}})
	if re{{.Abbreviation}}, err := service.Get{{.StructName}}({{.Abbreviation}}.ID); err != nil {
        global.LOG.Error("查询失败!", zap.Any("err", err))
		response.FailWithMessage("查询失败", err, c)
	} else {
		response.OkWithData(gin.H{"re{{.Abbreviation}}": re{{.Abbreviation}}}, c)
	}
}

// List{{.StructName}} 分页获取{{.StructName}}列表
// @Tags {{.StructName}}
// @Summary 分页获取{{.StructName}}列表
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Param data query request.{{.StructName}}Search true "分页获取{{.StructName}}列表"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"获取成功"}"
// @Router /api/v1/{{.Abbreviation}} [get]
func List{{.StructName}} (c *gin.Context) {
	var pageInfo request.{{.StructName}}Search
	err := c.ShouldBindQuery(&pageInfo)
	if err != nil {
		response.FailWithMessage("参数错误", err, c)
		return
	}
	if list, total, err := service.List{{.StructName}}(pageInfo); err != nil {
	    global.LOG.Error("获取失败!", zap.Any("err", err))
        response.FailWithMessage("获取失败", err, c)
    } else {
        response.OkWithDetailed(response.PageResult{
            List:     list,
            Total:    total,
            Page:     pageInfo.Page,
            PageSize: pageInfo.PageSize,
        }, "获取成功", c)
    }
}
