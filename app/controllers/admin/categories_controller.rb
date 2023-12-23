class Admin::CategoriesController < ApplicationController
    def index
        @categories = category.all
      end
    
      def new
        @Category = category.new
      end
    
      def create
        @category = Category.new(category_params)
      
        if @category.save
          redirect_to admin_categories_path, notice: 'Category created successfully.'
        else
          render :new
        end
      end