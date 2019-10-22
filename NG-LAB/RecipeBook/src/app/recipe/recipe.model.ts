import { Ingredient } from '../shopp/ingredient.model';

export interface Recipe {
  name: string;
  detail: string;
  ingredients: Ingredient[];
}
