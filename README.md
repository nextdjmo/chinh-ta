# Chính Tả Full v4.2 Lean DB

## Bản này tối ưu gì?

- Xóa Worker/checker cũ bị chạy song song với checker V4.
- Không còn tải `compactLexicon` 50.000 từ từ Nhost khi mở trang.
- Không còn query `word_variants + dictionary_words + word_examples` hai lần.
- `word_examples` không tải ở startup.
- `dictionary_words` liên quan đến lỗi được tải theo chunk 400 UUID.
- Checker, Từ điển, Luyện nhanh và Chọn từ đúng dùng chung một biến `ACTIVE`.
- `context_rules` trong Nhost được dùng trực tiếp làm quy tắc ngữ cảnh đã xác minh.
- Corpus lớn chỉ tải khi người dùng bấm **Kiểm tra** lần đầu.
- Bỏ heuristic cặp hai từ toàn cục vốn vừa nặng vừa dễ báo nhầm.
- Memoize tìm ứng viên lexical để một từ lạ lặp lại không bị tính lại.

## Bản deploy khuyên dùng

Dùng `index.html` cùng thư mục với:
- `spell-unigram.json.gz`
- `spell-bigram.json.gz`

Hai file corpus được trình duyệt tải **chỉ khi bấm Kiểm tra lần đầu** và sau đó được browser cache.

## Nhost

Chạy `nhost-performance-indexes.sql` một lần trong SQL Editor.
Admin vẫn phân trang 50 mục/lần; không tải toàn bộ dictionary vào DOM.
