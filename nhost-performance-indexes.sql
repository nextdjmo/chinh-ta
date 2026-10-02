-- Chính Tả v4.2 — index tối ưu cho Nhost/PostgreSQL
-- Chạy một lần. Các lệnh IF NOT EXISTS an toàn khi chạy lại.

CREATE INDEX IF NOT EXISTS word_variants_dictionary_word_id_idx
  ON public.word_variants (dictionary_word_id);

CREATE INDEX IF NOT EXISTS word_variants_wrong_lower_idx
  ON public.word_variants (lower(wrong));

-- Nếu cột wrong_normalized đã tồn tại theo schema hiện tại:
CREATE INDEX IF NOT EXISTS word_variants_wrong_normalized_idx
  ON public.word_variants (wrong_normalized);

CREATE INDEX IF NOT EXISTS word_examples_dictionary_word_id_idx
  ON public.word_examples (dictionary_word_id);

CREATE INDEX IF NOT EXISTS dictionary_words_correct_lower_idx
  ON public.dictionary_words (lower(correct));

CREATE INDEX IF NOT EXISTS dictionary_words_active_correct_idx
  ON public.dictionary_words (is_active, correct);

CREATE INDEX IF NOT EXISTS context_rules_active_priority_pattern_idx
  ON public.context_rules (is_active, priority DESC, pattern);

CREATE INDEX IF NOT EXISTS context_rules_target_idx
  ON public.context_rules (target);

-- Tùy chọn nhưng rất đáng dùng cho ô tìm kiếm quản trị với ILIKE '%...%'.
-- Nếu pg_trgm chưa bật, chạy 3 dòng dưới.
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE INDEX IF NOT EXISTS dictionary_words_correct_trgm_idx
  ON public.dictionary_words USING gin (correct gin_trgm_ops);
CREATE INDEX IF NOT EXISTS dictionary_words_meaning_trgm_idx
  ON public.dictionary_words USING gin (meaning gin_trgm_ops);
CREATE INDEX IF NOT EXISTS context_rules_pattern_trgm_idx
  ON public.context_rules USING gin (pattern gin_trgm_ops);
