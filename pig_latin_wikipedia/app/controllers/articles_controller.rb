class ArticlesController < ApplicationController
  def translate
    article_title = params[:article_title].gsub('_', ' ')
    article_content = fetch_article_content(article_title)

    if article_content.present?
      pig_latin_text = translate_to_pig_latin(article_content)

      render plain: pig_latin_text
    else
      render plain: 'Article not found', status: :not_found
    end
  end

  private

  def fetch_article_content(title)
    page = Wikipedia.find(title)
    page.content if page.present? && page.content.present?
  rescue StandardError => e
    Rails.logger.error("Error fetching article content: #{e.message}")
    nil
  end

  def translate_to_pig_latin(text)
    PigLatinTranslator.translate(text)
  rescue StandardError => e
    Rails.logger.error("Error translating to Pig Latin: #{e.message}")
    nil
  end
end
