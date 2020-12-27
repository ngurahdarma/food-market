//
//  LocaleMapper.swift
//  FoodMarket
//
//  Created by ngurah on 01/12/20.
//

struct LocaleMapper {
    static func mapCategoryEntityToModel(
        input entities: [CategoryEntity]
    ) -> [CategoryModel] {
        entities.map { entity in
            CategoryModel(
                categoryName: entity.categoryName,
                thumbnail: entity.thumbnail,
                descriptions: entity.descriptions
            )
        }
    }

    static func mapDetailCategoryEntityToModel(
        input entities: [DetailCategoryEntity]
    ) -> [DetailCategoryModel] {
        entities.map { entity in
            DetailCategoryModel(
                idMeal: entity.idMeal,
                meal: entity.meal,
                thumbnail: entity.thumbnail
            )
        }
    }

    static func mapDetailMealEntityToModel(
        input entities: [DetailMealEntity]
    ) -> [DetailMealModel] {
        entities.map { entity in
            DetailMealModel(
                meal: entity.meal,
                category: entity.category,
                area: entity.area,
                instruction: entity.instruction,
                thumbnail: entity.thumbnail
            )
        }
    }

    static func mapFavoriteEntityToDetailCategoryModel(
        input entities: [FavoriteEntity]
    ) -> [DetailCategoryModel] {
        entities.map { entity in
            DetailCategoryModel(
                idMeal: entity.idMeal,
                meal: entity.meal,
                thumbnail: entity.thumbnail
            )
        }
    }

    static func mapDetailCategoryModelToFavoriteEntity(
        input model: DetailCategoryModel
    ) -> FavoriteEntity {
        let entity = FavoriteEntity()
        entity.idMeal = model.idMeal
        entity.meal = model.meal
        entity.thumbnail = model.thumbnail
        return entity
    }
}
