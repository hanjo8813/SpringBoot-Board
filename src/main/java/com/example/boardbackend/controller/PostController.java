package com.example.boardbackend.controller;

import com.example.boardbackend.dto.PostDto;
import com.example.boardbackend.dto.request.UpdatePostRequest;
import com.example.boardbackend.dto.request.UpdateViewRequest;
import com.example.boardbackend.dto.response.BoardResponse;
import com.example.boardbackend.service.PostService;
import java.util.List;
import javax.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RequestMapping("/api/post")
@RestController
public class PostController {
    private final PostService postService;

    // 게시물 생성
    @PostMapping
    public ResponseEntity<PostDto> createPost(@Valid @RequestBody PostDto request) {
        PostDto response = postService.savePost(request);
        return ResponseEntity.ok(response);
    }

    // 게시물 전체 조회 (페이징)
    @GetMapping
    public ResponseEntity<Page<BoardResponse>> getAllPosts(
        @RequestParam("searchType") SearchType searchType,
        @RequestParam(value = "keyword") String keyword,
        Pageable pageable
    ) {
        Page<BoardResponse> response = postService.findPostsAll(searchType, keyword, pageable);
        return ResponseEntity.ok(response);
    }

    // user id로 게시물 조회
    @GetMapping("/user/{id}")
    public ResponseEntity<List<BoardResponse>> getUserPosts(@PathVariable("id") Long userId) {
        List<BoardResponse> response = postService.findPostsByUserId(userId);
        return ResponseEntity.ok(response);
    }

    // post id로 게시물 단건 조회
    @GetMapping("/{id}")
    public ResponseEntity<PostDto> getPost(@PathVariable("id") Long id) {
        PostDto response = postService.findPostById(id);
        return ResponseEntity.ok(response);
    }

    // 게시물 업데이트
    @PatchMapping("/{id}")
    public ResponseEntity<PostDto> updatePost(
            @PathVariable("id") Long id,
            @Valid @RequestBody UpdatePostRequest request
    ) {
        PostDto response = postService.updatePostById(id, request);
        return ResponseEntity.ok(response);
    }

    // 조회수 업데이트
    @PatchMapping("/{id}/view")
    public ResponseEntity<Long> updateView(
            @PathVariable("id") Long id,
            @Valid @RequestBody UpdateViewRequest request
    ) {
        Long response = postService.updateViewById(id, request);
        return ResponseEntity.ok(response);
    }

    // 게시물 삭제
    @DeleteMapping("/{id}")
    public ResponseEntity deletePost(@PathVariable("id") Long id) {
        postService.deletePostById(id);
        return ResponseEntity.ok().build();
    }

}
