import React, { useEffect, useState } from 'react';
import axios from 'axios';
import Menu from '../components/Menu';
import origin from "../api/origin";

function Posting(props) {

    // State
    const userId = localStorage.getItem("userId");
    const [userInfo, setUserInfo] = useState({});
    const [postInfo, setPostInfo] = useState({});

    // Effect
    useEffect(() => {
        axios.get(origin + `/user/${userId}`)
            .then(res => {
                setUserInfo(res.data)
                setPostInfo({ title: "", content: "", userInfo : res.data })
            })
    }, []);

    // Handler
    const titleHandler = (e) => setPostInfo({ ...postInfo, title: e.currentTarget.value })
    const contentHandler = (e) => setPostInfo({ ...postInfo, content: e.currentTarget.value })

    // Button
    const savePost = () => {
        axios.post(origin + "/post", postInfo)
            .then(res => {
                alert("게시물이 등록되었습니다.")
                props.history.push(`/post/${res.data.id}`);
            })
            .catch(err => {
                if (err.response.status == 400 || err.response.status == 404)
                    alert(err.response.data.message);
            });
    };

    return (
        <div>
            <Menu />

            <h2>게시물 작성</h2>
            <hr /><br />

            <div className="div_wrapper_posting">
                <ul>
                    <li><b>작성자</b>: {userInfo.email}</li>
                    <li><b>이름</b>: {userInfo.name}</li>
                </ul>

                <input style={{ width: "100%" }} type="text" placeholder="제목" onChange={titleHandler} />
                <br /><br />
                <textarea style={{ width: "100%", height: "300px" }} placeholder="내용을 입력하세요" onChange={contentHandler} />
                <div style={{ textAlign: "center" }}>
                    <button onClick={savePost}>등록하기</button>
                </div>

            </div>

        </div>
    );
}

export default Posting;
