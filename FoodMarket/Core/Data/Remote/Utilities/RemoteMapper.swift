//
//  RemoteMapper.swift
//  FoodMarket
//
//  Created by ngurah on 30/11/20.
//

struct RemoteMapper {
    static func mapCategoryResponseToModel(
        input responses: [CategoryResponse]
    ) -> [CategoryModel] {
        responses.map { response in
            CategoryModel(
                categoryName: response.categoryName ?? "",
                thumbnail: response.thumbnail ?? "",
                descriptions: response.descriptions ?? ""
            )
        }
    }

    static func mapCategoryResponseToEntity(
        input responses: [CategoryResponse]
    ) -> [CategoryEntity] {
        responses.map { response in
            let entity = CategoryEntity()
            entity.categoryName = response.categoryName ?? ""
            entity.thumbnail = response.thumbnail ?? ""
            entity.descriptions = response.descriptions ?? ""
            return entity
        }
    }

    static func mapDetailCategoryResponseToModel(
        input responses: [DetailCategoryResponse]
    ) -> [DetailCategoryModel] {
        responses.map { response in
            DetailCategoryModel(
                idMeal: response.idMeal ?? "",
                meal: response.meal ?? "",
                thumbnail: response.thumbnail ?? ""
            )
        }
    }

    static func mapDetailCategoryResponseToEntity(
        input responses: [DetailCategoryResponse]
    ) -> [DetailCategoryEntity] {
        responses.map { response in
            let entity = DetailCategoryEntity()
            entity.idMeal = response.idMeal ?? ""
            entity.meal = response.meal ?? ""
            entity.thumbnail = response.thumbnail ?? ""
            entity.category = ""
            return entity
        }
    }

    static func mapDetailMealResponseToModel(
        input responses: [DetailMealResponse]
    ) -> [DetailMealModel] {
        responses.map { response in
            DetailMealModel(
                meal: response.meal ?? "",
                category: response.category ?? "",
                area: response.area ?? "",
                instruction: response.instruction ?? "",
                thumbnail: response.thumbnail ?? ""
            )
        }
    }

    static func mapDetailMealResponseToEntity(
        input responses: [DetailMealResponse]
    ) -> [DetailMealEntity] {
        responses.map { response in
            let entity = DetailMealEntity()
            entity.meal = response.meal ?? ""
            entity.category = response.category ?? ""
            entity.area = response.area ?? ""
            entity.instruction = response.instruction ?? ""
            entity.thumbnail = response.thumbnail ?? ""
            return entity
        }
    }
}
