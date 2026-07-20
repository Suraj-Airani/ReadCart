package com.readcart.dao;

import com.readcart.model.Category;
import java.util.List;

public interface CategoryDAO {

    List<Category> getAllCategories();

    Category getCategoryById(int categoryId);
}
